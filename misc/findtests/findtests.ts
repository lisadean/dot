import fs from 'fs';
import path from 'path';
import { glob } from 'glob';
import { minimatch } from 'minimatch';

const findFiles = (
	pattern: string | string[],
	directory: string,
	exclusionPatterns?: string[]
) =>
	glob.globSync(pattern, {
		cwd: directory,
		ignore: exclusionPatterns || [],
		dot: true,
	});

const getFileName = (filePath: string) => path.basename(filePath);

// For each file in the sourceFiles array, check if there is a corresponding test file
// If there is no test file, add the file to a list of files without test files
const findTestFilesInSameDirectory = (
	sourceFiles: string[],
	testFiles: string[]
): string[] => {
	const noTestFiles: string[] = [];
	sourceFiles.forEach((sourceFile) => {
		const testFile = sourceFile
			.replace(/\.ts$/, '.test.ts')
			.replace(/\.tsx$/, '.test.tsx')
			.replace(/\.component\./, '.');
		if (!testFiles.includes(testFile)) {
			noTestFiles.push(sourceFile);
		}
	});
	return noTestFiles;
};

function findPossibleTestMatches(
	sourceFilesWithoutTests: string[],
	testFilesInBWS: string[]
) {
	const possibleTests: string[] = [];
	const sourceFilesWithoutPossibleTests: string[] = [];
	sourceFilesWithoutTests.forEach((sourceFile) => {
		const testFile = sourceFile
			.replace(/\.ts$/, '.test.ts')
			.replace(/\.tsx$/, '.test.tsx');
		const testFileBaseName = getFileName(testFile);
		const testFileInBWS = testFilesInBWS.find(
			(file) =>
				getFileName(file).replace(/\.component\./, '.') ===
				getFileName(testFile)
		);
		if (
			testFileInBWS?.includes('client/utils/string/general.utils.test.ts')
		) {
			// console.log('sourceFile', sourceFile);
		}
		if (testFileInBWS) {
			possibleTests.push(testFileInBWS);
		} else {
			sourceFilesWithoutPossibleTests.push(sourceFile);
		}
	});
	return [possibleTests, sourceFilesWithoutPossibleTests];
}

type PrintFileListOptions = {
	details: boolean;
};
const printFileList = (
	fileList: string[],
	message: string,
	options?: PrintFileListOptions
) => {
	console.log(`${message}: ${fileList.length}`);
	if (options?.details) {
		fileList.sort().forEach((file) => console.log(file));
	}
};

function main() {
	const fwsDirectory = '/Users/abb2175/repos/work/fws/src';
	const bwsDirectory = '/Users/abb2175/repos/work/bws/src';
	const typescriptFilePattern = '**/*.{ts,tsx}';
	const testFilePattern = '**/*.test.{ts,tsx}';
	const exclusionPatterns = [
		'**/*.d.{ts,tsx}',
		'**/__generated__/*',
		'**/*.story.tsx',
		'**/client/routes/generated-routes.tsx',
		'**/server/index.tsx',
		'**/client/index.tsx',
		'**/storybook-docs/**/*',
		'**/third-party/**/*',
		'**/**/*.mock-data.ts',
		'**/**/*.mocks.ts',
		'**/__mocks__/**',
		'**/jest.config.js',
		'**/jest',
		'**/graphql/*.package.ts',
		'**/graphql/root-package.ts',
	];
	const sourceFiles = findFiles(typescriptFilePattern, fwsDirectory, [
		...exclusionPatterns,
		testFilePattern,
	]);
	printFileList(sourceFiles, 'Typescript files found in FWS');

	const testFilesInFWS = findFiles(
		testFilePattern,
		fwsDirectory,
		exclusionPatterns
	);
	printFileList(testFilesInFWS, 'Test files found in FWS');

	const sourceFilesWithoutTests = findTestFilesInSameDirectory(
		sourceFiles,
		testFilesInFWS
	);
	printFileList(sourceFilesWithoutTests, 'Files without test files', {
		details: false,
	});

	const testFilesInBWS = findFiles(
		testFilePattern,
		bwsDirectory,
		exclusionPatterns
	);
	printFileList(testFilesInBWS, 'Test files found in BWS', {
		details: false,
	});

	const [possibleTests, sourceFilesWithoutPossibleTests] =
		findPossibleTestMatches(sourceFilesWithoutTests, testFilesInBWS);
	printFileList(possibleTests, 'Possible matching test files in BWS', {
		details: false,
	});
	printFileList(
		sourceFilesWithoutPossibleTests,
		'Files without possible matching test files',
		{
			details: true,
		}
	);
}

main();
