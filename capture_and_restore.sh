# Capture and download backup. Then upload it to local database
rm latest.dump
# HEROKU_POSTGRESQL_BRONZE_URL
heroku pg:backups capture DATABASE_URL
heroku pg:backups download
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U carlson -d text_api_dev latest.dump
