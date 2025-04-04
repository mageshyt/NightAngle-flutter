#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
    echo "📄 Loading environment variables from .env file..."
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        if [[ $key =~ ^[[:space:]]*$ ]] || [[ $key =~ ^# ]]; then
            continue
        fi
        # Remove leading/trailing whitespace and quotes
        key=$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/^"//;s/"$//')
        
        if [ ! -z "$key" ]; then
            export "$key=$value"
        fi
    done < .env
else
    echo "⚠️  Warning: .env file not found in current directory"
fi

# Check if backup file is provided
if [ -z "$1" ]; then
    echo "❌ Error: Please provide the backup file path"
    echo "Usage: ./restore-db.sh <backup-file-path>"
    echo "Example: ./restore-db.sh ./backups/backup_20231225_123456.sql"
    exit 1
fi

BACKUP_FILE=$1

# Check if backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Error: Backup file not found: $BACKUP_FILE"
    echo "Please ensure the backup file exists and try again."
    exit 1
fi


# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "❌ Error: DATABASE_URL environment variable is not set"
    echo "Please set DATABASE_URL in your environment or .env file"
    echo "Example: DATABASE_URL=postgresql://user:password@localhost:5432/dbname"
    exit 1
fi

echo $DATABASE_URL

# Test database connection
if ! psql "$DATABASE_URL" -c '\q' 2>/dev/null; then
    echo "❌ Error: Could not connect to database"
    echo "Please check your DATABASE_URL and ensure the database is running"
    exit 1
fi

echo "🔄 Starting database restore from $BACKUP_FILE..."
echo "⚠️  Warning: This will overwrite the current database contents"
read -p "Are you sure you want to continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Restore cancelled"
    exit 1
fi

echo "📦 Restoring database..."
if psql "$DATABASE_URL" < "$BACKUP_FILE"; then
    echo "✅ Database restore completed successfully!"
else
    echo "❌ Database restore failed!"
    echo "Please check the error messages above and try again"
    exit 1
fi
