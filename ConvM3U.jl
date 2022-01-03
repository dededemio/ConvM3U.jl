using NKFtool

folder = "C:\\Playlists\\" # 変換元M3Uファイルを置いてあるフォルダパス
list = readdir(folder)
for file in list
    if occursin("m3u", file)
        # M3Uファイルの読込元と出力先を開く
        filein = folder * file
        fileout = folder*"UTF-8\\"*file # 
        fw = open(fileout, "w")
        fr = open(filein, "r")
    
        # fileinの文字列のエンコードをUTF-8に変換
        lines = nkf_convert(fr) 
        # フォルダパスをクラウドストレージに合わせる
        lines = replace(lines, "C:\\MUSIC"=>"/Ubuntu/MUSIC")
        # 区切り文字をスラッシュに変換する
        lines = replace(lines, "\\"=>"/")
        # コメント行と"\r"だけの行を除いて書き込み
        for line in split(lines, "\n")
            if !occursin("#", line) && !(line=="\r")
                println(fw, line)
            end
        end
        close(fr)
        close(fw)
    end    
end
