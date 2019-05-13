set -e

BUILD_DIR=${BUILD_DIR-.build}
GO_DIR=$BUILD_DIR/protos-go
COMMIT=$(git rev-parse --short HEAD)

mkdir -p $BUILD_DIR
git clone https://${GH_TOKEN}@github.com/jjbubudi/protos-go.git $GO_DIR

if [ "$TRAVIS" = true ]; then
    echo "Setting up permissions for Travis"
    sudo chown -R travis:travis /home/travis/
fi

echo "Copying generated files"
cp -R .gen/go/* $GO_DIR

cd $GO_DIR
git add -N .

if ! git diff --exit-code > /dev/null; then
    git add .
    git commit -m "Update generated Go code from ${COMMIT}"
    git push origin HEAD
else
    echo "No changes detected"
fi

echo "Cleaning up"
cd - > /dev/null
rm -rf $GO_DIR

echo "Done"