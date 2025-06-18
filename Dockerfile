# Etapa de construcción con Swift 5.10
FROM swift:5.10 AS builder

WORKDIR /app
COPY . .
RUN swift build -c release

# Etapa final con la misma versión de Swift (no hay imagen slim oficial para swift:5.10)
FROM swift:5.10

WORKDIR /app

# Copia el binario compilado desde la etapa builder
COPY --from=builder /app/.build/release/Netflix .

EXPOSE 8080

CMD ["./Netflix", "serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]
