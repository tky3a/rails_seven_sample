module StaticPagesHelper
    #  created_atを年月日にフォーマットし直す
    def created_at(datetime)
        datetime.strftime("%Y年%m月%d日")
    end
end
