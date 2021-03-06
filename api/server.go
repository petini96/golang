package api

import (
	"github.com/gin-gonic/gin"
	db "github.com/petini96/simpleblank/db/sqlc"
)

//server serves HTTP request for our banking service
type Server struct {
	store  *db.Store
	router *gin.Engine
}

// NewServer creates a new HTTP server and setup routing
func NewServer(store *db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	router.POST("/accounts", server.CreateAccount)

	server.router = router
	return server
}

//start and runs HTTP server on specifc address
func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}
