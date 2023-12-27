//
//  EnglishCourse.swift
//  StudyCrunch
//
//  Created by Jun Gu on 12/27/23.
//

struct EnglishCourse {
  let course = {
    try! Course.Builder()
      .setEmoji(emoji: "📕")
      .setName(name: "English")
      .setDescription(description: "The worst subject!")
      .setChapterBuilders(chapterBuilders: [
        Chapter.Builder()
          .setName(name: "Variables")
          .setDescription(description: "Super useful")
          .setFlashcards(jsonFileName: "computer-science")
          .setMarkdown(markdownFilename: "sample"),
        Chapter.Builder()
          .setName(name: "Loops")
          .setMarkdown(markdownFilename: "sample"),
        Chapter.Builder()
          .setName(name: "Conditionals")
          .setMarkdown(markdownFilename: "sample"),
        Chapter.Builder()
          .setName(name: "Arrays")
          .setMarkdown(markdownFilename: "sample"),
        Chapter.Builder()
          .setName(name: "Pointers")
          .setMarkdown(markdownFilename: "sample"),
        Chapter.Builder()
          .setName(name: "Complexity")
          .setMarkdown(markdownFilename: "sample"),
        Chapter.Builder()
          .setName(name: "Depth-first search")
          .setMarkdown(markdownFilename: "sample"),
        Chapter.Builder()
          .setName(name: "Complexity")
          .setMarkdown(markdownFilename: "sample"),
        Chapter.Builder()
          .setName(name: "Depth-first search")
          .setMarkdown(markdownFilename: "sample"),
        Chapter.Builder()
          .setName(name: "Depth-first search")
          .setMarkdown(markdownFilename: "sample"),
      ])
      .build()
  }()
}
