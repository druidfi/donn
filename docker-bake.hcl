variable "REPO_NAME" {
    default = "druidfi/donn"
}

group "default" {
    targets = ["donn-node-16", "donn-node-18"]
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
    tags = ["${REPO_NAME}:node-16", "${REPO_NAME}:1.0-node-16"]
}

target "donn-node-18" {
    inherits = ["common"]
    args = {
        NODE_VERSION = 18
    }
    tags = ["${REPO_NAME}:node-18", "${REPO_NAME}:1.0-node-18", "${REPO_NAME}:latest"]
}
