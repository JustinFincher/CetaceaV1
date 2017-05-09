cd "$(dirname "$0")"

jazzy \
  --objc \
  --clean \
  --author Justin Fincher \
  --module CetaceaSharedFramework \
  --module-version 0.1 \
  --documentation CSF \
        --abstract CSF \
   --umbrella-header Cetacea/CetaceaSharedFramework/CetaceaSharedFramework.h \
   --framework-root Cetacea \
  --author_url https://fincher.im \
  --output Doc/CetaceaSharedFramework 