package repository

import (
	"context"
	"errors"
	"fmt"
	"github.com/jackc/pgx/v4/pgxpool"
)

type Config struct {
	Host     string
	Port     string
	Username string
	Password string
	DBName   string
	//SSLMode  string
}

func NewPostgresDB(cfg Config) (*pgxpool.Pool, error) {
	databaseUrl := fmt.Sprintf("host=%s port=%s user=%s dbname=%s password=%s",
		cfg.Host, cfg.Port, cfg.Username, cfg.DBName, cfg.Password )

	dbPool, err := pgxpool.Connect(context.Background(), databaseUrl)
	if err != nil {
		return nil, errors.New("database is unavailable. try again or check credentials")
	}

	err = dbPool.Ping(context.Background())
	if err != nil {
		return nil, err
	}

	return dbPool, nil
}
