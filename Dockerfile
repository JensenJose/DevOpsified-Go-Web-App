FROM golang:1.22.5 as base

WORKDIR /app

COPY go.mod . 
# Go mod is the go equivalent for requirements.txt

RUN go mod download
# Downloads the required packages/libraries

COPY . .

RUN go build -o main .
# This will create an executable binary for the application

# Final stage -> Distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]