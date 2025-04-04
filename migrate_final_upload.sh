#!/bin/bash

# =======================
# Typesense Collection Migration Script
# =======================
# This script creates a Typesense collection and imports documents into it.
# Customize the values below before running.

# --- Configuration ---
API_KEY=""
HOST=""
COLLECTION_NAME=""
SCHEMA_FILE=""
DATA_FILE=""
DELETE_EXISTING=  # Set to true to delete the collection before creating

# --- Functions ---
delete_collection() {
  echo "Deleting existing collection: $COLLECTION_NAME"
  curl -s -X DELETE -H "X-TYPESENSE-API-KEY: $API_KEY" \
       "$HOST/collections/$COLLECTION_NAME"
}

create_collection() {
  echo "Creating collection: $COLLECTION_NAME"
  curl -s -X POST -H "X-TYPESENSE-API-KEY: $API_KEY" \
       -H "Content-Type: application/json" \
       -d @"$SCHEMA_FILE" \
       "$HOST/collections"
}

import_documents() {
  echo "Importing documents into collection: $COLLECTION_NAME"
  curl -s -X POST -H "X-TYPESENSE-API-KEY: $API_KEY" \
       --data-binary @"$DATA_FILE" \
       "$HOST/collections/$COLLECTION_NAME/documents/import?action=upsert"
}

# --- Execution ---
if [[ "$DELETE_EXISTING" == "true" ]]; then
  delete_collection
fi

create_collection
import_documents

echo "✅ Migration complete!"
