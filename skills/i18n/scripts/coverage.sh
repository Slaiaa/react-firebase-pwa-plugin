#!/bin/bash
# i18n Coverage Report Script
# Generates translation coverage statistics

set -e

LOCALES_DIR="${1:-public/locales}"
BASE_LANG="${2:-en}"

if [ ! -d "$LOCALES_DIR" ]; then
    echo "Error: Locales directory not found: $LOCALES_DIR"
    echo "Usage: coverage.sh [locales-path] [base-language]"
    exit 1
fi

echo "# i18n Coverage Report"
echo ""
echo "Generated: $(date)"
echo "Locales directory: $LOCALES_DIR"
echo "Base language: $BASE_LANG"
echo ""

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Warning: jq not installed. Install with: brew install jq"
    echo "Falling back to basic counting..."
    USE_JQ=false
else
    USE_JQ=true
fi

# Count keys in a JSON file
count_keys() {
    local file="$1"
    if [ "$USE_JQ" = true ]; then
        jq '[.. | strings] | length' "$file" 2>/dev/null || echo 0
    else
        # Fallback: count lines with string values
        grep -c '": "' "$file" 2>/dev/null || echo 0
    fi
}

# Get all keys from a JSON file
get_keys() {
    local file="$1"
    if [ "$USE_JQ" = true ]; then
        jq -r 'paths(scalars) | join(".")' "$file" 2>/dev/null || true
    fi
}

echo "## Languages Found"
echo ""

# List all languages
for lang_dir in "$LOCALES_DIR"/*/; do
    if [ -d "$lang_dir" ]; then
        lang=$(basename "$lang_dir")
        echo "- $lang"
    fi
done
echo ""

echo "## Keys Per Namespace"
echo ""

# Track totals
declare -A lang_totals

for lang_dir in "$LOCALES_DIR"/*/; do
    if [ -d "$lang_dir" ]; then
        lang=$(basename "$lang_dir")
        echo "### $lang"
        echo ""

        total=0
        for file in "$lang_dir"*.json; do
            if [ -f "$file" ]; then
                ns=$(basename "$file" .json)
                count=$(count_keys "$file")
                echo "- $ns: $count keys"
                total=$((total + count))
            fi
        done

        echo "- **Total: $total keys**"
        echo ""
        lang_totals[$lang]=$total
    fi
done

echo "## Coverage Comparison"
echo ""

base_total=${lang_totals[$BASE_LANG]:-0}

if [ "$base_total" -eq 0 ]; then
    echo "Warning: Base language ($BASE_LANG) has 0 keys or not found"
else
    echo "| Language | Keys | Coverage |"
    echo "|----------|------|----------|"

    for lang in "${!lang_totals[@]}"; do
        total=${lang_totals[$lang]}
        if [ "$base_total" -gt 0 ]; then
            coverage=$((total * 100 / base_total))
        else
            coverage=0
        fi

        if [ "$lang" = "$BASE_LANG" ]; then
            echo "| $lang (base) | $total | 100% |"
        else
            echo "| $lang | $total | $coverage% |"
        fi
    done
fi

echo ""

# Missing keys analysis (if jq available)
if [ "$USE_JQ" = true ] && [ -d "$LOCALES_DIR/$BASE_LANG" ]; then
    echo "## Missing Keys Analysis"
    echo ""

    for lang_dir in "$LOCALES_DIR"/*/; do
        if [ -d "$lang_dir" ]; then
            lang=$(basename "$lang_dir")
            if [ "$lang" != "$BASE_LANG" ]; then
                echo "### $lang - Missing Keys"
                echo ""

                missing_count=0
                for base_file in "$LOCALES_DIR/$BASE_LANG"/*.json; do
                    if [ -f "$base_file" ]; then
                        ns=$(basename "$base_file" .json)
                        lang_file="$lang_dir/$ns.json"

                        if [ -f "$lang_file" ]; then
                            # Compare keys
                            base_keys=$(get_keys "$base_file" | sort)
                            lang_keys=$(get_keys "$lang_file" | sort)

                            missing=$(comm -23 <(echo "$base_keys") <(echo "$lang_keys") 2>/dev/null || true)

                            if [ -n "$missing" ]; then
                                count=$(echo "$missing" | wc -l | tr -d ' ')
                                missing_count=$((missing_count + count))
                                echo "**$ns** ($count missing):"
                                echo '```'
                                echo "$missing" | head -10
                                if [ "$count" -gt 10 ]; then
                                    echo "... and $((count - 10)) more"
                                fi
                                echo '```'
                                echo ""
                            fi
                        else
                            echo "**$ns**: File missing entirely"
                            echo ""
                        fi
                    fi
                done

                if [ "$missing_count" -eq 0 ]; then
                    echo "No missing keys found!"
                fi
                echo ""
            fi
        fi
    done
fi

echo "## Recommendations"
echo ""
echo "1. Ensure all namespaces exist in all languages"
echo "2. Run this report after adding new translation keys"
echo "3. Review missing keys and add translations"
echo "4. Consider using CI to block PRs with missing translations"
