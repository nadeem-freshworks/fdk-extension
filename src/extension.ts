
import * as vscode from 'vscode';
import * as path from 'path';

export function activate(context: vscode.ExtensionContext) {
	console.log('Congratulations, your extension "fdk-extension" is now active!');
	let disposable = vscode.commands.registerCommand('fdk-extension.installFdk', () => {
		
		vscode.window.showInformationMessage('Hello World from fdk-extension!');

		const scriptPath = path.join(context.extensionPath, 'src/scripts', 'mac.sh');
        const terminal = vscode.window.createTerminal('Install FDK');
        terminal.show();
        terminal.sendText(`bash ${scriptPath}`);		
		terminal.sendText(`clear`);
		

	});

	 disposable = vscode.commands.registerCommand('fdk-extension.loadFdk', () => { 
		const terminal = vscode.window.createTerminal('Load  FDK');
        terminal.show();
		const localZshrcPath = path.join(context.extensionPath, 'src/scripts', 'local.zshrc');
		terminal.sendText(`export PATH="/Users/nbhati/codebase/freshdesk/fdk-extension/mynode/bin:$PATH"`);
		terminal.sendText(`clear`);
		terminal.sendText(`successfully installed fdk`);
		
		const outputChannel = vscode.window.createOutputChannel('Load FDK');
		outputChannel.appendLine('FDK loaded process completed.');
		outputChannel.show();

		
	});
	context.subscriptions.push(disposable);
}

// This method is called when your extension is deactivated
export function deactivate() {
	console.log('Your extension "fdk-extension" is now deactivated!');
}
