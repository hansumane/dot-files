function gitll
    git log --graph --date=format-local:"%Y/%m/%d %H:%M" --pretty=format:"%C(red)%h%C(reset) | %s %C(green)(%cd)%C(reset) %C(blue)%an%C(reset) %C(bold magenta)<%ae>%C(reset)%C(yellow)%d%C(reset)"
end
