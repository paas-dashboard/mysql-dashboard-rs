# mysql-dashboard
Mysql dashboard for fun.

## backend api command
### create database
```bash
curl -iv -X POST -H "Content-Type: application/json" http://localhost:10008/api/mysql/databases/create -d '{"database_name":"test-db"}'
```
