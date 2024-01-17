
import * as vscode from 'vscode';
import * as path from 'path';
import * as os from 'os';


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
		terminal.sendText(`clear`);

	} else {
		console.log('Unsupported operating system.');
	}

}

function loadFdk(platform: string, context: vscode.ExtensionContext) {
	if (platform === 'win32') {
		
		console.log('You are on Windows.');
		const terminal = vscode.window.createTerminal('Load  FDK');
		terminal.show();
		const loadfdkFilePath = path.join(context.extensionPath, 'src/scripts/windows', 'loadFdk.ps1');
		const configPath = path.join(context.extensionPath, 'src/', 'configs.json')
		terminal.sendText(`${loadfdkFilePath} -configPath ${configPath}`);

	} else if (platform === 'darwin') {
		const terminal = vscode.window.createTerminal('Load  FDK');
		terminal.show();
		const localZshrcPath = path.join(context.extensionPath, 'src/scripts/mac', 'local.zshrc');
		terminal.sendText(`source ${localZshrcPath}`);
		terminal.sendText(`clear`);

		const outputChannel = vscode.window.createOutputChannel('Load FDK');
		outputChannel.appendLine('FDK loaded process completed.');
		outputChannel.show();
	}  else {
		console.log('Unsupported operating system.');
	}
}
export function activate(context: vscode.ExtensionContext) {

	const platform: string = os.platform();

	console.log('Congratulations, your extension "fdk-extension" is now active!');
	let disposable = vscode.commands.registerCommand('fdk-extension.installFdk', () => {
		const message = "hello world";
		vscode.window.showInformationMessage(message);
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
