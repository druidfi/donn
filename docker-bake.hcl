variable "REPO_NAME" {
    default = "druidfi/donn"
}

variable "VERSION" {
    default = "1.2"
}

group "default" {
    targets = ["donn-node-18", "donn-node-20", "donn-node-22"]
}

target "common" {
    platforms = ["linux/amd64", "linux/arm64"]
    context = "."
    labels = {
        "org.opencontainers.image.url" = "https://github.com/druidfi/donn"
        "org.opencontainers.image.source" = "https://github.com/druidfi/donn"
        "org.opencontainers.image.licenses" = "MIT"
        "org.opencontainers.image.vendor" = "Druid Oy"
        "org.opencontainers.image.created" = "${timestamp()}"
    }
}

target "donn-node-18" {
    inherits = ["common"]
    args = {
        NODE_VERSION = 18
    }
    tags = ["${REPO_NAME}:node-18", "${REPO_NAME}:${VERSION}-node-18"]
}

target "donn-node-20" {
    inherits = ["common"]
    args = {
        NODE_VERSION = 20
    }
    tags = ["${REPO_NAME}:node-20", "${REPO_NAME}:${VERSION}-node-20"]
}

target "donn-node-22" {
    inherits = ["common"]
    args = {
        NODE_VERSION = 22
    }
    tags = ["${REPO_NAME}:node-22", "${REPO_NAME}:${VERSION}-node-22", "${REPO_NAME}:latest"]
}
