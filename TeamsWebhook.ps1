class TeamsWebhook
{
    [System.Collections.Specialized.OrderedDictionary] static NewTeamsCard()
    {
        $card = [ordered]@{ 
            title = "Add Your Title" 
            text = " " 
            sections = @(([TeamsWebhook]::GetTeamsSections()))
        }
        return $card
    }

    [System.Collections.ArrayList] static GetTeamsSections()
    {
        [array]$sections = New-Object System.Collections.ArrayList
        $sections += [TeamsWebhook]::GetTeamsActivitySection()
        $sections += [TeamsWebhook]::GetTeamsFactSection()
        return $sections
    }

    [System.Collections.Specialized.OrderedDictionary] static GetTeamsActivitySection()
    {
        $section = [ordered]@{
            activityTitle = 'Add Activity Title' 
            activitySubtitle = 'Add Subtitle'
            #activityText = " " 
            activityImage = '.\image.png' 
        }
        return $section
    }
    [System.Collections.Specialized.OrderedDictionary] static GetTeamsFactSection()    
{
        $section = [ordered]@{
            title = 'Add Section Title'
            facts = @(
                @{
                    name = 'Test'
                    value = "Successful"
                }
            )
        }
        return $section
    }

    PostTeamsCard([string] $uri)
    {
        $body = ConvertTo-Json -Depth 4 -InputObject ([TeamsWebhook]::NewTeamsCard())
        Invoke-RestMethod -uri $uri -Method 'Post' -body $body  -ContentType 'application/json' | Out-Null
    }
}