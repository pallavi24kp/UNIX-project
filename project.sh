PROJECT_FOLDER="/home/pallavi/UNIXproject"
BACKUP_FOLDER="/home/pallavi/UNXIbackup"
LOG_FILE="$BACKUP_FOLDER/backup.log"

take_backup() {
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    BACKUP_FILE="$BACKUP_FOLDER/project_backup_$TIMESTAMP.tar.gz"
    tar -czf "$BACKUP_FILE" "$PROJECT_FOLDER"

    if [ $? -eq 0 ]; then
        echo "$(date): Backup Successful -> $BACKUP_FILE" | tee -a "$LOG_FILE"
        echo "Backup created successfully: $BACKUP_FILE"
    else
        echo "$(date): Backup Failed" | tee -a "$LOG_FILE"
        echo "Backup failed!"
    fi
}
list_backups() {
    echo "==== Existing Backups in $BACKUP_FOLDER ===="
    ls -lh "$BACKUP_FOLDER" | grep project_backup_
    echo "==========================================="
}

while true; do
    echo ""
    echo "===== Project Backup Menu ====="
    echo "1. Take Backup"
    echo "2. List Backups"
    echo "3. Exit"
    echo "==============================="
    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1) take_backup ;;
        2) list_backups ;;
        3) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice! Please enter 1, 2, or 3." ;;
    esac
