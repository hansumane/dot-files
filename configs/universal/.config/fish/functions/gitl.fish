function gitl
    git log --graph --pretty=format:"%C(red)%h%C(reset) | %s %C(green)(%cr)%C(reset) %C(blue)%an%C(reset) %C(bold magenta)<%ae>%C(reset)%C(yellow)%d%C(reset)"
end
