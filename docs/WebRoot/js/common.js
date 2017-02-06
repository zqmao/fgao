function getClipboard() {
	if (window.clipboardData) {
		return (window.clipboardData.getData('Text'));
	} else if (window.netscape) {
		netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');
		var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
		if (!clip)
			return;
		var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
		if (!trans)
			return;
		trans.addDataFlavor('text/unicode');
		clip.getData(trans, clip.kGlobalClipboard);
		var str = new Object();
		var len = new Object();
		try {
			trans.getTransferData('text/unicode', str, len);
		} catch (error) {
			return null;
		}
		if (str) {
			if (Components.interfaces.nsISupportsWString)
				str = str.value.QueryInterface(Components.interfaces.nsISupportsWString);
			else if (Components.interfaces.nsISupportsString)
				str = str.value.QueryInterface(Components.interfaces.nsISupportsString);
			else
				str = null;
		}
		if (str) {
			return (str.data.substring(0, len.value / 2));
		}
	}
	return null;
}