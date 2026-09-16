import re

def prune_new_year_greetings(greeting):
    template_phrases = [
        r"あけましておめでとう(?:ございます)?",
        r"旧年中は大変お世話になりました",
        r"昨年は.*お世話になりました",
        r"本年も(?:どうぞ)?よろしく(?:お願いいたします|お願いします)?",
        r"謹賀新年",
        r"新春の(?:お慶び|喜び)を申し上げます",
        r"賀正",
        r"迎春",
        r"謹んで新年の(?:お喜び|お祝い)を申し上げます",
        r"本年も変わらぬ(?:ご愛顧|お引き立て)を賜りますよう",
        r"新年を迎え",
        r"皆様のご健康とご多幸をお祈り申し上げます",
        r"平素より(?:格別の|ひとかたならぬ)?ご高配を賜り",
        r"昨年に引き続き(?:本年も)?よろしくお願いいたします",
        r"輝かしい一年となりますように",
        r"新年にあたり.*ご挨拶申し上げます",
        r"ご家族皆様のご健康を心よりお祈り申し上げます",
        ...,
    ]

    pattern = re.compile("|".join(template_phrases))
    filtered_greeting = re.sub(pattern, "", greeting)

    return filtered_greeting
