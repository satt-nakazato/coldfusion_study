// 参照URL　https://tm-progapp.hatenablog.com/entry/2020/11/18/205607
/** 枠線のスタイル */
const borderStyle = {
	top: { style: 'thin', color: { argb: 'FFCCCCCC' } },
	left: { style: 'thin', color: { argb: 'FFCCCCCC' } },
	bottom: { style: 'thin', color: { argb: 'FFCCCCCC' } },
	right: { style: 'thin', color: { argb: 'FFCCCCCC' } },
};
/** ヘッダ行の背景色 */
const headerFillStyle = {
	type: 'pattern',
	pattern: 'solid',
	fgColor: { argb: 'FFDDDDDD' },
};
/** ヘッダ行のフォント */
const headerFontStyle = {
	bold: true,
};
/** 偶数行の背景色 */
const bodyEvenFillStyle = {
	type: 'pattern',
	pattern: 'solid',
	fgColor: { argb: 'FFF5F5F5' },
};
/** 奇数行の背景色 */
const bodyOddFillStyle = {
	type: 'pattern',
	pattern: 'solid',
	fgColor: { argb: 'FFFFFFFF' },
};


const clickButtonAsync = async (e) => {
	// Workbookの作成
    const workbook = new ExcelJS.Workbook();
    // Workbookに新しいWorksheetを追加
    workbook.addWorksheet('My Sheet');
    // ↑で追加したWorksheetを参照し変数に代入
    const worksheet = workbook.getWorksheet('My Sheet');

    // 列を定義
	worksheet.columns = [
		{ header: 'ID', key: 'id', width: 10 },
		{ header: '氏名', key: 'name', width: 40 },
		{ header: '価格', key: 'price', width: 30 },
	];
	
    // 行を定義
    worksheet.addRow({id: 1001, name: 'ハンバーガー', price: 170});
    worksheet.addRow({id: 1002, name: 'チーズバーガー', price: 200});
    worksheet.addRow({id: 1003, name: '照り焼きチキンバーガー', price: 260});
    
	// すべての行を走査
	worksheet.eachRow((row, rowNumber) => {
		// すべてのセルを走査
		row.eachCell((cell, colNumber) => {
		if (rowNumber === 1) {
			// ヘッダ行のスタイルを設定
			cell.fill = headerFillStyle;
			cell.font = headerFontStyle;
		} else {
			if (rowNumber % 2 === 0) {
			// ボディ行（偶数行）のスタイルを設定
			cell.fill = bodyEvenFillStyle;
			} else {
			// ボディ行（奇数行）のスタイルを設定
			cell.fill = bodyOddFillStyle;
			}
		}
		// セルの枠線を設定
		cell.border = borderStyle;
		});
		// 行の設定を適用
		row.commit();
	});
	
    // UInt8Arrayを生成
    const uint8Array = await workbook.xlsx.writeBuffer();
    // Blobを生成
    const blob = new Blob([uint8Array], {type: 'application/octet-binary'});
    // DL用URLを生成し、aタグからダウンロードを実行
    const url = window.URL.createObjectURL(blob);
    // aタグを生成
    const a = document.createElement('a');
    // aタグのURLを設定
    a.href = url;
    // aタグにdownload属性を付け、URLがダウンロード対象になるようにします
    a.download = `price_list.xlsx`;
    // aタグをクリックさせます
    a.click();
    // ダウンロード後は不要なのでaタグを除去
    a.remove();
}
