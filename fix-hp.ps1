$sortedLabels = @(
    "3D Printing",
    "Agile Project Management",
    "AI for Beginners",
    "Basics of Finance",
    "Business Communications",
    "Business Email",
    "Cash Flow",
    "Circular Economy",
    "Customer Experience (CX) for Business Success",
    "Customer Relationship Management",
    "Data Science & Analytics",
    "Design Thinking",
    "Effective Business Websites",
    "Effective Leadership",
    "Effective Presentations",
    "Finding Funding",
    "Growth Engine for Your Business",
    "Introduction to Cybersecurity Awareness",
    "Introduction to Digital Business Skills",
    "Inventory Management",
    "IT for Business Success",
    "Marketing Benefits vs. Features",
    "Presenting Data",
    "Profit and Loss",
    "Resume Writing and Job Interviewing",
    "Sales Forecasting",
    "Selling Online",
    "Setting Prices",
    "Social Entrepreneurship",
    "Social Media Marketing",
    "Starting a Small Business",
    "Strategic Planning",
    "Success Mindset",
    "The Art of Sales: Fundamentals of Selling",
    "Unique Value Proposition",
    "Your Target Audience"
)

$filenameMap = @{
    "3D Printing" = "3d-printing.jpg"
    "Agile Project Management" = "agile-project-management.jpg"
    "AI for Beginners" = "ai-for-beginners.jpg"
    "Basics of Finance" = "basics-of-finance.jpg"
    "Business Communications" = "business-communications.jpg"
    "Business Email" = "business-email.jpg"
    "Cash Flow" = "cash-flow.jpg"
    "Circular Economy" = "circular-economy.jpg"
    "Customer Experience (CX) for Business Success" = "customer-experience-cx-for-business-success.jpg"
    "Customer Relationship Management" = "customer-relationship-management.jpg"
    "Data Science & Analytics" = "data-science-&-analytics.jpg"
    "Design Thinking" = "design-thinking.jpg"
    "Effective Business Websites" = "effective-business-websites.jpg"
    "Effective Leadership" = "effective-leadership.jpg"
    "Effective Presentations" = "effective-presentations.jpg"
    "Finding Funding" = "finding-funding.jpg"
    "Growth Engine for Your Business" = "growth-engine-for-your-business.jpg"
    "Introduction to Cybersecurity Awareness" = "introduction-to-cybersecurity-awareness.jpg"
    "Introduction to Digital Business Skills" = "introduction-to-digital-business-skills.jpg"
    "Inventory Management" = "inventory-management.jpg"
    "IT for Business Success" = "it-for-business-success.jpg"
    "Marketing Benefits vs. Features" = "marketing-benefits-vs.-features.jpg"
    "Presenting Data" = "presenting-data.jpg"
    "Profit and Loss" = "profit-and-loss.jpg"
    "Resume Writing and Job Interviewing" = "resume-writing-and-job-interviewing.jpg"
    "Sales Forecasting" = "sales-forecasting.jpg"
    "Selling Online" = "selling-online.jpg"
    "Setting Prices" = "setting-prices.jpg"
    "Social Entrepreneurship" = "social-entrepreneurship.jpg"
    "Social Media Marketing" = "social-media-marketing.jpg"
    "Starting a Small Business" = "starting-a-small-business.jpg"
    "Strategic Planning" = "strategic-planning.jpg"
    "Success Mindset" = "success-mindset.jpg"
    "The Art of Sales: Fundamentals of Selling" = "the-art-of-sales-fundamentals-of-selling.jpg"
    "Unique Value Proposition" = "unique-value-proposition.jpg"
    "Your Target Audience" = "your-target-audience.jpg"
}

$openTag = '  <div id="panel-hp" class="cert-panel">'
$gridOpen = '    <div class="certs-grid">'

$allCards = ""
foreach ($label in $sortedLabels) {
    $filename = $filenameMap[$label]
    $labelDisplay = $label
    $altDisplay = $label
    $card = @"
        <div class="cert-card" onclick="openModal(this)">
          <div class="cert-img-wrap">
            <img src="assets/certificates/$filename" alt="$altDisplay" loading="lazy">
            <div class="cert-overlay"><span>View Certificate</span></div>
          </div>
          <div class="cert-footer">
            <div class="cert-label">$labelDisplay</div>
          </div>
        </div>

"@
    $allCards = $allCards + $card
}

$panelEnd = "    </div></div>"
$closePanel = "  </div>"

$newHpSection = $openTag + "`r`n" + $gridOpen + "`r`n" + $allCards.TrimEnd() + "`r`n" + $panelEnd + "`r`n" + $closePanel

$files = @(
    "C:\Users\Admin\1 Code program\my-portfolio\index.html",
    "C:\Users\Admin\1 Code program\my-portfolio\portfolio-1.html"
)

foreach ($file in $files) {
    $content = Get-Content -LiteralPath $file -Raw
    
    $idxHp = $content.IndexOf('  <div id="panel-hp" class="cert-panel">')
    $idxOpswat = $content.IndexOf('  <div id="panel-opswat" class="cert-panel">')
    
    if ($idxHp -ge 0 -and $idxOpswat -ge 0) {
        $before = $content.Substring(0, $idxHp)
        $after = $content.Substring($idxOpswat)
        $newContent = $before + $newHpSection + "`r`n" + $after
        Set-Content -LiteralPath $file -Value $newContent -NoNewline
        Write-Host "Updated $file"
    } else {
        Write-Host "FAILED to find markers in $file"
        Write-Host "  HP index: $idxHp"
        Write-Host "  Opswat index: $idxOpswat"
    }
}

Write-Host ""
Write-Host "=== SUMMARY ==="
Write-Host "Card count: $($sortedLabels.Count)"
Write-Host "First 5:"
$sortedLabels | Select-Object -First 5 | ForEach-Object { "  $_" }
Write-Host "Last 5:"
$sortedLabels | Select-Object -Last 5 | ForEach-Object { "  $_" }
