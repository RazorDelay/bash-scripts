#!/bin/bash


DATABASE_FILE="passwords.db"


SQL_COMMANDS="CREATE TABLE entries (
    id  INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    );"


 if [ -e "$DATABASE_FILE" ]; then
     echo "Database already exists"
     exit 0
 fi
 
 if sqlite3 "$DATABASE_FILE" "$SQL_COMMANDS"; then
       echo "Database is up"
 else
       echo "[!] ERROR: task failed"
 fi
 
        
