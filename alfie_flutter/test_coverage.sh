# Temporarily disable "exit on error"
set +e

flutter test --coverage --branch-coverage

TEST_EXIT_CODE=$?

# Re-enable "exit on error"
set -e

lcov --remove coverage/lcov.info \
  'lib/graphql/generated/**' \
  -o coverage/lcov.info --branch-coverage --ignore-errors inconsistent,inconsistent

if [ "$GITHUB_ACTIONS" != "true" ]; then
  genhtml coverage/lcov.info -o coverage/html --branch-coverage --ignore-errors inconsistent,inconsistent

  open coverage/html/index.html
fi

exit $TEST_EXIT_CODE