
import * as vscode from 'vscode';
import * as path from 'path';
import * as os from 'os';
import * as fs from 'fs';

const platform: string = os.platform();


function installFDK(platform: string, context: vscode.ExtensionContext) {

	if (platform === 'win32') {
		console.log('You are on Windows.');
		const terminal = vscode.window.createTerminal('Install FDK');
		const installFdkFilePath = path.join(context.extensionPath, 'src/scripts/windows', 'installFdk.ps1');
		const configPath = path.join(context.extensionPath, 'src/', 'configs.json')
		terminal.sendText(`${installFdkFilePath} -configPath ${configPath}`);

	} else if (platform === 'darwin') {
		console.log('You are on macOS.');

		const scriptPath = path.join(context.extensionPath, 'src/scripts/mac', 'mac.sh');
		const terminal = vscode.window.createTerminal('Install FDK');
		terminal.show();
		terminal.sendText(`bash ${scriptPath}`);

	} else {
		console.log('Unsupported operating system.');
	}

}

function loadFdk(platform: string, context: vscode.ExtensionContext, terminal: vscode.Terminal | undefined = undefined) {

	if (!terminal) {
		terminal = vscode.window.createTerminal('Load  FDK');
	}
	terminal.show();

	// check the if config.json file has the data or not
	if (platform === 'win32') {
		const loadfdkFilePath = path.join(context.extensionPath, 'src/scripts/windows', 'loadFdk.ps1');
		const configPath = path.join(context.extensionPath, 'src/', 'configs.json')
		terminal.sendText(`${loadfdkFilePath} -configPath ${configPath}`);
	} else if (platform === 'darwin') {
		const localZshrcPath = path.join(context.extensionPath, 'src/scripts/mac', 'local.zshrc');
		terminal.sendText(`source ${localZshrcPath}`);
	} else {
		console.log('Unsupported operating system.');
	}
}

export function activate(context: vscode.ExtensionContext) {
	// You can also listen for the onDidOpenTerminal event

	// create a file  if not exist
	const configPath = path.join(context.extensionPath, 'src/', 'configs.json')
	if (!fs.existsSync(configPath)) {
		fs.writeFileSync(configPath, '{}');
	}
	
	let terminalOpenedDisposable = vscode.window.onDidOpenTerminal((terminal) => {
		loadFdk(platform, context, terminal);
	});

	// Make sure to dispose of the event handler when the extension is deactivated
	context.subscriptions.push(terminalOpenedDisposable);

	console.log('Congratulations, your extension "fdk-extension" is now active!');
	let disposable = vscode.commands.registerCommand('fdk-extension.installFdk', () => {
		installFDK(platform, context);
	});

	disposable = vscode.commands.registerCommand('fdk-extension.loadFdk', () => {
		loadFdk(platform, context);
	});


	context.subscriptions.push(disposable);
}

// This method is called when your extension is deactivated
export function deactivate() {
	console.log('Your extension "fdk-extension" is now deactivated!');
}
