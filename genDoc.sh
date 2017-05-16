cd "$(dirname "$0")"

jazzy \
  --objc \
  -e ./Cetacea \
  --min-acl internal \
  --clean \
  --author Justin Fincher \
  --module CetaceaSharedFramework \
   --umbrella-header Cetacea/CetaceaSharedFramework/CetaceaSharedFramework.h \
   --framework-root Cetacea \
  --author_url https://fincher.im \
  --output docs/CetaceaSharedFramework \
    --theme fullwidth 