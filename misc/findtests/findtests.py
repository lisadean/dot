import os
import re
import fnmatch

def find_files_with_regex(directory, pattern):
    """
    Recursively find files matching the given regex pattern in a directory.
    """
    files = []
    regex = re.compile(pattern)
    for root, _, filenames in os.walk(directory):
        for filename in filenames:
            if regex.match(filename):
                files.append(os.path.join(root, filename))
    return files

def filter_files(file_list, exclusion_pattern):
    filtered_files = []
    for file in file_list:
        if not any(fnmatch.fnmatch(file, pattern) for pattern in exclusion_pattern):
            filtered_files.append(file)

    return filtered_files


def check_for_test_files(source_files, test_directory):
    """
    Check if test files exist for the given source files in the test directory.
    """
    filtered_files = []
    for source_file in source_files:
        base_name = os.path.splitext(os.path.basename(source_file))[0]
        possible_test_names = [f"{base_name}.test.ts", f"{base_name}.test.tsx"]

        found_test = False
        for root, _, filenames in os.walk(test_directory):
            if any(test_name in filenames for test_name in possible_test_names):
                found_test = True
                filtered_files.append(os.path.join(root, source_file))
                break

def print_file_list(file_list, message):
    print(f"'{message}':")
    count = 0
    for file in sorted(file_list):
        print(file)
        count += 1
    print(f"Total files found: {count}")

fws_directory = "/Users/abb2175/repos/work/fws/src"
bws_directory = "/Users/abb2175/repos/work/bws/src"
typescript_files = r"^(?!.*\.d\.tsx?$).*\.(ts|tsx)$"  # Regex to exclude .d.ts and .d.tsx files
exclusions = ["**/__generated__/*", "src/**/*.story.tsx", "src/client/routes/generated-routes.tsx", "src/server/index.tsx", "src/storybook-docs/**/*", "src/third-party/**/*", "src/**/*.mock-data.ts", "src/**/*.mocks.ts"]
test_files = r".*\.test\.tsx?$"
# sonar.exclusions=/node_modules/**/*, **/__generated__/*, src/**/*.story.tsx, src/client/routes/generated-routes.tsx, src/server/index.tsx, src/storybook-docs/**/*, src/third-party/**/*, src/**/*.mock-data.ts, src/**/*.mocks.ts
# sonar.test.inclusions=src/**/*.test.ts, src/**/*.test.tsx
# sonar.coverage.exclusions=src/**/*.story.tsx, src/storybook-docs/**/*, src/third-party/**/*, src/client/index.tsx, src/client/pages/dev-resources/**, **/jest.config.js, **/__mocks__/*, **/jest-*
# sonar.test.exclusions=src/**/*.story.tsx, src/storybook-docs/**/*, src/third-party/**/*, src/client/pages/dev-resources/**


def main():
    # find all typescript files in FWS
    source_files = find_files_with_regex(fws_directory, typescript_files)
    print_file_list(source_files, "Files found in FWS")
    # exclude files that match the exclusion patterns
    filtered_files = filter_files(source_files, exclusions)
    print_file_list(filtered_files, "Filtered files")
    # exclude files that have a matching test file
    no_test_files = check_for_test_files(source_files, fws_directory)
    print_file_list(no_test_files, "Files without test files")
    # print the remaining files in FWS
    # find all test files in BWS
    # find test files that match the remaining files

main()

# Check if corresponding test files exist in the test directory
# check_for_test_files(source_files, test_directory)
