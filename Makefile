postgres:
	docker run --name postgres -p 5435:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres
createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_blank
dropdb:
	docker exec -it postgres dropdb simple_blank
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5435/simple_blank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5435/simple_blank?sslmode=disable" -verbose down
sqlc:
	docker run --rm -v /containers/simple-blank:/src -w /src kjconroy/sqlc generate
startpostgres:
	docker container start postgres
test:
	go test -v -cover ./...
psql:
	docker exec -it postgres psql -U root -d simple_blank
.PHONY: postgres createdb dropdb migrateup migratedown sqlc startpostgres test psql
