#!/bin/bash

# Configuration
BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_${TIMESTAMP}.sql"

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

# Check for required commands
if ! command -v pg_dump &> /dev/null; then
    echo "❌ Error: pg_dump command not found!"
    echo "Please install PostgreSQL client tools first."
    exit 1
fi

# Ensure backup directory exists
if ! mkdir -p "$BACKUP_DIR" 2>/dev/null; then
    echo "❌ Error: Unable to create backup directory: $BACKUP_DIR"
    echo "Please check your permissions and try again."
    exit 1
fi
echo "📂 Backup directory: $BACKUP_DIR"

echo "🔒 Database backup script"



# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "❌ Error: DATABASE_URL environment variable is not set"
    echo "Please set the DATABASE_URL in your .env file or environment:"
    echo "DATABASE_URL='postgresql://user:password@host:port/dbname'"
    exit 1
fi
echo "🔄 Starting database backup..."

# Perform the backup
if pg_dump "$DATABASE_URL" \
    --clean --if-exists \
    --format=plain \
    --no-owner \
    --no-privileges \
    > "$BACKUP_DIR/$BACKUP_FILE" 2>/tmp/pg_dump_error; then
    
    echo "✅ Backup completed successfully!"
    echo "📁 Backup saved to: $BACKUP_DIR/$BACKUP_FILE"
    echo "📊 Backup size: $(du -h "$BACKUP_DIR/$BACKUP_FILE" | cut -f1)"
else
    echo "❌ Backup failed!"
    echo "Error message:"
    cat /tmp/pg_dump_error
    rm -f /tmp/pg_dump_error
    exit 1
fi
