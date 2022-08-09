variable "REPO_NAME" {
    default = "druidfi/donn"
}

group "default" {
    targets = ["donn-node-16"]
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
    tags = ["${REPO_NAME}:node-16"]
}
