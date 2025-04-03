#!/usr/bin/fish

set QUESTION $argv

set RESPONSE (curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$GEMINI_API_KEY" \
  -H 'Content-Type: application/json' \
  -X POST \
  -d "{
    \"contents\": [{
      \"parts\":[{\"text\": \"$QUESTION\"}]
    }]
  }")

# Extract the text from the JSON response
set ANSWER (echo "$RESPONSE" | jq -r '.candidates[0].content.parts[0].text')

# Check if an answer was found and print it nicely
if test -n "$ANSWER"
  echo "Answer:"
  echo "-------"
  echo "$ANSWER"
else
  echo "Error: Could not retrieve answer."
  echo "Raw Response:"
  echo "$RESPONSE"
end
