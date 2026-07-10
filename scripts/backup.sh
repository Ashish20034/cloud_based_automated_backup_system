#!/bin/bash

# Environment variables
export HOME=/home/ubuntu
export PATH=/usr/local/bin:/usr/bin:/bin

# Source folder to backup
SOURCE="/home/ubuntu/cloud-disaster-recovery-system"

# Local backup storage folder
BACKUP="/home/ubuntu/backup"

# Date and time for unique backup filename
DATE=$(date +%F-%H-%M-%S)

# Create backup directory if it does not exist
/bin/mkdir -p "$BACKUP"

# Create compressed backup
/bin/tar -czf "$BACKUP/backup-$DATE.tar.gz" "$SOURCE"

# Upload backup to AWS S3
/usr/local/bin/aws s3 cp "$BACKUP/backup-$DATE.tar.gz" s3://dia-backup-system/ >> /home/ubuntu/s3-upload.log 2>&1

# Log completion
echo "Backup completed on $(date)" >> /home/ubuntu/backup-status.log
