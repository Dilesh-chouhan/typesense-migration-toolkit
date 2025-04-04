#!/bin/bash

# Default values (left blank intentionally for generalization)
API_KEY=""
HOST=""
COLLECTION=""
OUTPUT_FILE=""

# Function to display usage
usage() {
  echo "Usage: $0 -k API_KEY -h HOST -c COLLECTION [-o OUTPUT_FILE]"
  echo "  -k API_KEY     : Your Typesense API key (required)"
  echo "  -h HOST        : Typesense host (required)"
  echo "  -c COLLECTION  : Collection name (required)"
  echo "  -o OUTPUT_FILE : Output file name (optional, default: auto-generated)"
  exit 1
}

# Parse command line arguments
while getopts "k:h:c:o:" opt; do
  case $opt in
    k) API_KEY="$OPTARG" ;;
    h) HOST="$OPTARG" ;;
    c) COLLECTION="$OPTARG" ;;
    o) OUTPUT_FILE="$OPTARG" ;;
    *) usage ;;
  esac
done

# Validate required inputs
if [[ -z "$API_KEY" || -z "$HOST" || -z "$COLLECTION" ]]; then
  echo "Error: Missing required arguments."
  usage
fi

# Set default output filename if not provided
OUTPUT_FILE="${OUTPUT_FILE:-documents-export-${COLLECTION}-$(date +"%Y-%m-%d--%H-%M-%S").jsonl}"

# Export API key for curl
export TYPESENSE_API_KEY="${API_KEY}"

echo "Downloading documents from https://${HOST}/collections/${COLLECTION}/documents/export"
echo "Output file: ${OUTPUT_FILE}"

# Execute export
curl -s -H "X-TYPESENSE-API-KEY: ${TYPESENSE_API_KEY}" \
     "https://${HOST}/collections/${COLLECTION}/documents/export" > "${OUTPUT_FILE}"

# Confirm result
if [ $? -eq 0 ]; then
  echo "✅ Export complete!"
  echo "📁 File: ${OUTPUT_FILE}"
  echo "📦 Size: $(du -h "${OUTPUT_FILE}" | cut -f1)"
else
  echo "❌ Export failed. Please check your parameters and network."
  exit 1
fi
