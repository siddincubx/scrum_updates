class ScrumUpdate {
    date string
    summary string
    accomplishments string
    plans string
    sentiments string
    blockers string
    speakers string[] @description(#"
        List of speakers who spoke in the scrum update.
    "#)
    duration_minutes int @description(#"
        Total duration of the scrum update in minutes."#)
}

function ExtractScrumUpdate(transcript: string, current_date: string) -> ScrumUpdate {
    client CustomGemini
    prompt #"
        Current date is {{ current_date }}. Use if date cannot be determined from transcript.

        Extract the following scrum update information from the transcript:

        {{ transcript }}
        
        {{ctx.output_format}}

    "#
}

test sample_transcript_record{
    functions [ExtractScrumUpdate]
    args{
        current_date "2024-06-15"
        transcript #"
            Priya 9:30 AM
Morning folks, let's do a quick sync. How's everyone doing?

Raj 9:31 AM
Hey all. I wrapped up the backend logic for the payment gateway yesterday, and all the tests look good. Today I'm planning to jump on the API for pulling transaction history. So far, so good on my end.

Anjali 9:33 AM
Morning. I'm still wrestling with the user profile page. That new component just refuses to play nice on mobile. I'm going to keep poking at it today, but honestly, I'm a bit stuck. The CSS is being a real pain.

Samir 9:34 AM
Good morning. My test plan for the payment gateway is all done. I'm ready to start hammering it as soon as the feature is on the QA server. Just waiting on that build.

Priya 9:36 AM
Nice one, Raj! How soon do you think you can get that build over to Samir? Anjali, no worries, that responsive stuff can be tricky. Raj, any chance you could lend her a hand with that CSS later? I know you're busy, but we need to show the new profile page to Sarah from the marketing team by Thursday.

Raj 9:38 AM
Yeah, for sure. @Priya, I can push the build to QA now, it should be ready for @Samir in about 30 minutes. @Anjali, happy to help. I'll send you a calendar invite for 11 AM, and we can screenshare.

Anjali 9:39 AM
Thanks so much, Raj, that would be amazing! 11 AM works perfectly.

Samir 9:40 AM
Sweet, thanks Raj. I'll keep an eye out for it.

Priya 9:41 AM
Awesome, sounds like a plan. Great stuff, team. Let's have a good one!
        "#

    }
}

test negative_transcript{
    functions [ExtractScrumUpdate]
    args{
        current_date "2024-06-15"
        transcript #"David 10:14 AM
Just following up on my email from yesterday. Do we have an ETA for the final copy for the partner outreach sequence? The deadline was EOD yesterday.

Chloe 10:16 AM
The analytics from the Q3 campaign suggest that sequences sent out on Wednesdays have a significantly lower open rate. Just putting that out there since we're already behind.

Mark 10:20 AM
I'm working on it. I had to pivot after our "strategy alignment" call because the initial direction was apparently not what we wanted, despite it being in the approved creative brief.

Brenda 10:22 AM
Okay, let's keep the discussion focused on a path forward. Mark, I understand the frustration, but we need to be agile. David needs that copy to start his workflow.

David 10:25 AM
Exactly. My hands are tied until I get it. The partners are expecting to hear from us this week, and I'd prefer not to have to explain another delay to them.

Mark 10:28 AM
I’ll get it to you when it’s done. It’s hard to maintain quality when the goalposts are moved every six hours.

Chloe 10:29 AM
The data also shows rushed copy performs 40% worse in A/B tests."#
    }
        
}


test updates_from_email{
    functions [ExtractScrumUpdate]
    args{
        current_date "2024-06-15"
        transcript #"
            Subject: Follow up on Project Atlas copy
From: David Miller d.miller@company.com
To: Mark Chen m.chen@company.com
Cc: Brenda Valenti b.valenti@company.com; Chloe Davis c.davis@company.com
Date: Tue, Oct 28, 2025, 10:14 AM

Hi Mark,

Just wanted to circle back on the final copy for the Project Atlas partner outreach sequence. The deadline was EOD yesterday, and I need it to begin prepping the mail merge and scheduling the sends.

Do you have an updated ETA for me?

Thanks,
David

Subject: Re: Follow up on Project Atlas copy
From: Chloe Davis c.davis@company.com
To: David Miller d.miller@company.com; Mark Chen m.chen@company.com
Cc: Brenda Valenti b.valenti@company.com
Date: Tue, Oct 28, 2025, 10:16 AM

Just a thought on this – as we move into midweek, it might be relevant to note that the analytics from the Q3 campaign suggest that sequences sent out on Wednesdays have a significantly lower open rate compared to Tuesdays.

Just putting that out there since we’re already behind schedule.

Best,
Chloe

Subject: Re: Follow up on Project Atlas copy
From: Mark Chen m.chen@company.com
To: Chloe Davis c.davis@company.com; David Miller d.miller@company.com
Cc: Brenda Valenti b.valenti@company.com
Date: Tue, Oct 28, 2025, 10:20 AM

I am actively working on it.

As I’m sure we all remember from our “strategy alignment” call on Monday, the initial direction was apparently not what was wanted, despite that direction being explicitly signed-off on in the approved creative brief. I had to pivot and effectively restart the entire sequence from scratch yesterday afternoon.

Subject: Re: Follow up on Project Atlas copy
From: Brenda Valenti b.valenti@company.com
To: Mark Chen m.chen@company.com; Chloe Davis c.davis@company.com; David Miller d.miller@company.com
Date: Tue, Oct 28, 2025, 10:22 AM

Team,

Let’s keep the discussion focused on a path forward.

Mark, I understand the frustration with the pivot, but our ability to remain agile is key to this project's success. Thank you for adapting so quickly.

David is blocked and needs that copy to start his workflow. Can you provide a realistic ETA for when he can expect a draft?

Thanks,
Brenda

Subject: Re: Follow up on Project Atlas copy
From: David Miller d.miller@company.com
To: Brenda Valenti b.valenti@company.com; Mark Chen m.chen@company.com; Chloe Davis c.davis@company.com
Date: Tue, Oct 28, 2025, 10:25 AM

Exactly. I appreciate the need to be agile, but my hands are completely tied until I get the copy.

These partners are expecting to hear from us this week as per the timeline we communicated. I'd prefer not to have to send another "we'll be in touch soon" email and explain yet another delay. It undermines our credibility.

Subject: Re: Follow up on Project Atlas copy
From: Mark Chen m.chen@company.com
To: David Miller d.miller@company.com; Brenda Valenti b.valenti@company.com; Chloe Davis c.davis@company.com
Date: Tue, Oct 28, 2025, 10:28 AM

I’ll get it to you when it’s done.

It is difficult to maintain a high standard of quality when the goalposts are moved every six hours. I am doing my best to incorporate the new "vision" while ensuring the messaging doesn't sound completely disjointed. I should have something for you this afternoon, but it will be a rush job. It’s easy to just hit ‘send,’ but crafting a message that resonates actually takes thought.

Subject: Re: Follow up on Project Atlas copy
From: Chloe Davis c.davis@company.com
To: Mark Chen m.chen@company.com; David Miller d.miller@company.com; Brenda Valenti b.valenti@company.com
Date: Tue, Oct 28, 2025, 10:29 AM

Speaking of quality, the data also shows that rushed copy performs 40% worse in A/B tests and leads to a 15% higher unsubscribe rate. Just something to keep in mind as we manage timelines.
        "#
    }
}
