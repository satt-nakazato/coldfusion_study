// 参照URL　https://tm-progapp.hatenablog.com/entry/2020/11/18/205607

const clickButtonAsync = async (e) => {
	// Workbookの作成
    const workbook = new ExcelJS.Workbook();
    // Workbookに新しいWorksheetを追加
    workbook.addWorksheet('My Sheet');
    // ↑で追加したWorksheetを参照し変数に代入
    const worksheet = workbook.getWorksheet('My Sheet');

    // 列を定義
    worksheet.columns = [
      { header: 'ID', key: 'id' },
      { header: '氏名', key: 'name' },
      { header: '価格', key: 'price' },
    ];

    // 行を定義
    worksheet.addRow({id: 1001, name: 'ハンバーガー', price: 170});
    worksheet.addRow({id: 1002, name: 'チーズバーガー', price: 200});
    worksheet.addRow({id: 1003, name: '照り焼きチキンバーガー', price: 260});
    
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
