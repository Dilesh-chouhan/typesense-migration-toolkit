# 📦 Typesense Data Migration (Copy/Move)

A simple process to copy or move your Typesense data from one instance to another. Perfect for migrating from Typesense Cloud to your own Docker instance or between any Typesense environments.

![Typesense Logo](https://typesense.org/assets/images/typesense-logo.svg)

## 🚀 Quick Migration Guide

### Step 1: Export Schema from Typesense Cloud
1. Log in to your Typesense Cloud dashboard
2. Go to your collection
3. Click on "Export Schema" button
4. Save the schema file (it will be a JSON file)

### Step 2: Download Data from Source
```bash
./download_typesense_data.sh -k YOUR_API_KEY -h YOUR_HOST -c YOUR_COLLECTION
```
This will create a backup file in `.jsonl` format.

### Step 3: Import/Upload Data to Destination
```bash
./migrate_final_upload.sh
```

---

## 📋 Prerequisites

- Access to Typesense Cloud dashboard
- Source Typesense instance (where your data is currently)
- Destination Typesense instance (where you want to copy data to)
- API keys for both instances
- Basic command line knowledge

---

## 🔧 Detailed Setup Guide

### 1. Get Schema from Typesense Cloud
- Log in to [Typesense Cloud](https://cloud.typesense.org)
- Navigate to your collection
- Click "Export Schema" and save the JSON file
- Keep this file safe - you'll need it for the import

### 2. Download Data from Cloud
```bash
# Example: Download from Typesense Cloud
./download_typesense_data.sh -k abc123 -h api.typesense.org -c products
```
This will generate a `.jsonl` file containing your collection data.

### 3. Import to Docker Instance
```bash
# Set your Docker instance details
export TYPESENSE_API_KEY="your_docker_api_key"
export TYPESENSE_HOST="http://localhost:8108"
export COLLECTION_NAME="products"
export SCHEMA_FILE="schema.json"  # The schema file you downloaded from Typesense Cloud

# Run the import script
./migrate_final_upload.sh
```

---

## 📝 Complete Example

Let's say you want to move your data from Typesense Cloud to your local Docker:

1. **Get Schema from Cloud Dashboard:**
   - Log in to Typesense Cloud
   - Go to your collection
   - Export and save the schema JSON file

2. **Download Data from Cloud:**
```bash
./download_typesense_data.sh -k cloud_key -h api.typesense.org -c my_collection
```
This will create a `.jsonl` file with your collection data.

3. **Import to Docker:**
```bash
export TYPESENSE_API_KEY="docker_key"
export TYPESENSE_HOST="http://localhost:8108"
export COLLECTION_NAME="my_collection"
export SCHEMA_FILE="schema.json"  # Your downloaded schema file
./migrate_final_upload.sh
```

That's it! Your data is now copied to the new location. 🎉

---

## ⚠️ Important Notes

1. Don't forget to export the schema from Typesense Cloud first!
2. This is a COPY operation - your original data remains intact
3. Make sure you have enough space for the backup file
4. Check your network connection
5. Verify your API keys work
6. The process might take some time depending on your data size
7. Data is exported in `.jsonl` format (JSON Lines) for efficient processing

---

## 🤝 Need Help?

Feel free to open an issue if you run into any problems!

## 📄 License

MIT License - Feel free to use this for your data migration needs! 