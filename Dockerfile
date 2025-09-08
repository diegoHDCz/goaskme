# Estágio 1: Build da aplicação
FROM golang:1.22-alpine AS builder

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de módulo e baixa as dependências
COPY go.mod go.sum ./
RUN go mod download

# Sincroniza as dependências com o código fonte
COPY . .
RUN go mod tidy

# Instala o executável "tern" para as migrações
RUN go install github.com/jackc/tern@latest
# Compila a primeira aplicação
RUN CGO_ENABLED=0 go build -o /app/terndotenv ./cmd/tools/terndotenv/main.go

# Compila a segunda aplicação
RUN CGO_ENABLED=0 go build -o /app/wsrs ./cmd/wsrs/main.go

# Estágio 2: Imagem de produção final
FROM alpine:latest

# Define o diretório de trabalho na imagem final
WORKDIR /usr/local/bin

# Copia os binários compilados
COPY --from=builder /app/ternsdotenv .
COPY --from=builder /app/wsrs .
COPY --from=builder /go/bin/tern .

# Comando para executar as duas aplicações em sequência
ENTRYPOINT ["sh", "-c", "./terndotenv && ./wsrs"]