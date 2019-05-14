set -e

BUILD_DIR=.build
LANG=${LANG-"unknown"}
PROJECT_DIR=${BUILD_DIR}/protos-${LANG}
COMMIT=$(git rev-parse --short HEAD)

cloneRepository() {
    mkdir -p $PROJECT_DIR
    git clone https://${GH_TOKEN}@github.com/jjbubudi/protos-${LANG}.git $PROJECT_DIR
}

copyGeneratedFiles() {
    echo "Copying generated files"
    cp -R .gen/${LANG}/* $PROJECT_DIR
}

commitAndPush() {
    cd $PROJECT_DIR
    git add -N .
    if ! git diff --exit-code > /dev/null; then
        git add .
        git commit -m "Update generated code from ${COMMIT}"
        git push origin HEAD
    else
        echo "No changes detected"
    fi
    cd - > /dev/null
}

cloneRepository
copyGeneratedFiles
commitAndPush
