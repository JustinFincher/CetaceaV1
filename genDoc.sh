cd "$(dirname "$0")"

jazzy \
--sdk macosx \
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
  --theme docs/DocTemplate

# appledoc \
# --project-name "Cetacea Shared Framework" \
# --project-company "FinGameWorks" \
# --company-id "com.justzht" \
# --docset-atom-filename "CetaceaSharedFramework.atom" 
# --output "~/help" \
# --publish-docset \
# --logformat xcode \
# --keep-undocumented-objects \
# --keep-undocumented-members \
# --keep-intermediate-files \
# --no-repeat-first-par \
# --no-warn-invalid-crossref \
# "${PROJECT_DIR}"

/usr/local/bin/appledoc \
--project-name "${PROJECT_NAME}" \
--project-company "FinGameWorks" \
--company-id "com.justzht" \
--output "${PROJECT_DIR}"/../../docs \
--install-docset \
--clean-output \
--create-html \
--create-docset \
--publish-docset \
--logformat xcode \
--keep-undocumented-objects \
--keep-undocumented-members \
--keep-intermediate-files \
--search-undocumented-doc \
--print-information-block-titles \
--no-warn-invalid-crossref \
--merge-categories \
--exit-threshold 2 \
"${PROJECT_DIR}"