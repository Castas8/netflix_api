FROM swift:5.10 AS builder

WORKDIR /app
COPY . .
RUN swift build -c release

FROM swift:5.10-slim

WORKDIR /app

# Copia el binario compilado
COPY --from=builder /app/.build/release/Netflix .

EXPOSE 8080

# Comando por defecto para producción
CMD ["./Netflix", "serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]
