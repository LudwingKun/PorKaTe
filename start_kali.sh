#!/bin/sh

# Kali Linux Docker Launcher
# Compatible with bash, zsh, and sh
# Usage: ./start_kali.sh [build|run|rebuild]

IMAGE_NAME="PorKaTe/kali-linux-docker"
WORKSPACE_DIR="$(pwd)/workspace"

# Detect current shell
detect_shell() {
    if [ -n "$ZSH_VERSION" ]; then
        echo "zsh"
    elif [ -n "$BASH_VERSION" ]; then
        echo "bash"
    else
        echo "sh"
    fi
}

CURRENT_SHELL=$(detect_shell)

# Colors for output (POSIX compatible)
if [ -t 1 ]; then
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    RED='\033[0;31m'
    BLUE='\033[0;34m'
    NC='\033[0m'
else
    GREEN=''
    YELLOW=''
    RED=''
    BLUE=''
    NC=''
fi

# Print info message
print_info() {
    printf "${BLUE}[INFO]${NC} %s\n" "$1"
}

# Print success message
print_success() {
    printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"
}

# Print warning message
print_warning() {
    printf "${YELLOW}[WARNING]${NC} %s\n" "$1"
}

# Print error message
print_error() {
    printf "${RED}[ERROR]${NC} %s\n" "$1"
}

# Function to build the image
build_image() {
    print_info "Building Kali Docker image..."
    print_info "Shell detected: $CURRENT_SHELL"
    
    docker build -t $IMAGE_NAME .
    
    if [ $? -eq 0 ]; then
        print_success "Build completed successfully!"
    else
        print_error "Build failed!"
        exit 1
    fi
}

# Function to run the container
run_container() {
    # Create workspace directory if it doesn't exist
    if [ ! -d "$WORKSPACE_DIR" ]; then
        print_warning "Creating workspace directory..."
        mkdir -p "$WORKSPACE_DIR"
    fi
    
    print_info "Starting Kali container..."
    print_info "Shell: $CURRENT_SHELL"
    print_warning "Workspace: $WORKSPACE_DIR"
    print_warning "Type 'exit' to leave the container"
    echo ""
    
    docker run -it --rm --privileged \
        -v "$WORKSPACE_DIR:/root/workspace" \
        --network host \
        $IMAGE_NAME
}

# Function to check if image exists
image_exists() {
    docker image inspect $IMAGE_NAME >/dev/null 2>&1
    return $?
}

# Function to check if Docker is running
check_docker() {
    if ! docker info >/dev/null 2>&1; then
        print_error "Docker is not running!"
        print_info "Please start Docker Desktop and try again."
        exit 1
    fi
}

# Show usage
show_usage() {
    echo "Usage: $0 [build|run|rebuild|info]"
    echo ""
    echo "Commands:"
    echo "  build    - Build the Docker image only"
    echo "  run      - Run the container (builds if needed) [default]"
    echo "  rebuild  - Rebuild the image and run"
    echo "  info     - Show system and shell information"
    echo ""
    echo "Current shell: $CURRENT_SHELL"
}

# Show system info
show_info() {
    print_info "System Information"
    echo "  Shell: $CURRENT_SHELL"
    echo "  Shell Version: $(${SHELL} --version 2>/dev/null | head -n1)"
    echo "  Docker: $(docker --version 2>/dev/null || echo 'Not found')"
    echo "  Image exists: $(image_exists && echo 'Yes' || echo 'No')"
    echo "  Workspace: $WORKSPACE_DIR"
}

# Main script logic
check_docker

case "${1:-run}" in
    build)
        build_image
        ;;
    run)
        if ! image_exists; then
            print_warning "Image not found. Building first..."
            build_image
        fi
        run_container
        ;;
    rebuild)
        print_warning "Rebuilding image..."
        build_image
        run_container
        ;;
    info)
        show_info
        ;;
    -h|--help|help)
        show_usage
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac