getgenv().nice_popup = function(Title, Button1, Button2, Callback1, Callback2)
    local ErrorPrompt = getrenv().require(game.CoreGui.RobloxGui.Modules.ErrorPrompt)
    local prompt = ErrorPrompt.new("Default")
    prompt._hideErrorCode = true
    local Blur = Instance.new("BlurEffect")
    Blur.Parent = game.Lighting
    local gui = Instance.new("ScreenGui", game.CoreGui)
    prompt:setParent(gui)
    prompt:setErrorTitle(Title)
    prompt:updateButtons({{
      Text = Button1,
      Callback = function()
        pcall(Callback1)
        Blur:Destroy() prompt:_close()
      end,
    }, {
      Text = Button2,
      Callback = function()
        pcall(Callback2)
        Blur:Destroy() prompt:_close()
      end,
      Primary = true
    }}, 'Default')
    prompt:_open(Title)    
end
