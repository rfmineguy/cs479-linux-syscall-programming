docker_cmd='docker run -e HOST_PATH=$(pwd) --rm -it -w /root/workspace -v $(pwd):/root/workspace ubuntu-latest'

function usage {
    echo "usage: build <subcommand>";
    echo "Subcommands:";
    echo "  docker_get          : Build the required docker container"
    echo "  build               : Use the container to build the kernel"
    echo "  clean               : Use the container to clean the build files"
    echo "  run                 : Use the container to run the built exes"
    echo "  help                : Display this menu"
}

function handle_docker_get {
    docker build -t ubuntu-latest . --platform linux/amd64
}

function handle_build {
    eval $docker_cmd 'sh -c "make -C asm build; make -C c build"'
}

function handle_clean {
    eval $docker_cmd 'sh -c "make -C asm clean; make -C c clean"'
}

function handle_run {
    echo "================="
    echo "   Running asm"
    echo "================="
    eval $docker_cmd 'sh -c "cd ./asm/out/; ./main"; echo "Exited with code: $?"'

    echo "================="
    echo "   Running c"
    echo "================="
    eval $docker_cmd 'sh -c "cd ./c/out; ./main"; echo "Exited with code: $?"'
}


case "$1" in
    docker_get ) shift 1; handle_docker_get $@ ;;
    build )      shift 1; handle_build $@ ;;
    clean )      shift 1; handle_clean $@ ;;
    run )        shift 1; handle_run $@ ;;
    help )       usage ;;
    * ) echo "Incorrect usage"; usage ;;
esac
