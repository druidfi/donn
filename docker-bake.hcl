variable "REPO_NAME" {
    default = "druidfi/donn"
}

variable "VERSION" {
    default = "1.1"
}

group "default" {
    targets = ["donn-node-16", "donn-node-18", "donn-node-20"]
}

target "common" {
    platforms = ["linux/amd64", "linux/arm64"]
    context = "."
}

target "donn-node-16" {
    inherits = ["common"]
    args = {
        NODE_VERSION = 16
    }
    tags = ["${REPO_NAME}:node-16", "${REPO_NAME}:${VERSION}-node-16"]
}

target "donn-node-18" {
    inherits = ["common"]
    args = {
        NODE_VERSION = 18
    }
    tags = ["${REPO_NAME}:node-18", "${REPO_NAME}:${VERSION}-node-18", "${REPO_NAME}:latest"]
}

target "donn-node-20" {
    inherits = ["common"]
    args = {
        NODE_VERSION = 20
    }
    tags = ["${REPO_NAME}:node-20", "${REPO_NAME}:${VERSION}-node-20", "${REPO_NAME}:latest"]
}
