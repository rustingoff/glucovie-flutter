import "dart:async";

import "package:glucovie/pages/navigation/navigation.dart";
import "package:flutter/material.dart";
import "package:glucovie/models/note.dart";
import "package:glucovie/pages/notes_page.dart";
import "package:intl/intl.dart";
import "package:glucovie/utils.dart";

class HomeNotesPage extends StatefulWidget {
  const HomeNotesPage({Key? key}) : super(key: key);

  @override
  State<HomeNotesPage> createState() => _HomeNotesPageState();
}

class _HomeNotesPageState extends State<HomeNotesPage> {
  late Future<List<Note>> notes;
  late Future<List<Tag>> tags;
  List<Tag> _tags = [];
  Tag? selectedTag;

  List<int> selectedNotes = [];
  bool ascending = true;
  String sortBy = "updatedAt";
  Map<String, String> sortFields = {
    "Title": "title",
    "Created At": "createdAt",
    "Updated At": "updatedAt"
  };

  @override
  void initState() {
    super.initState();
    updateView();
  }

  FutureOr onGoBack(dynamic value) async {
    await updateView();
  }

  updateView() async {
    tags = Tag().select().toList();

    if (selectedTag != null) {
      notes = Note().select().tag.equals(selectedTag?.id).toList();
    } else {
      notes = Note().select().toList();
    }
    _tags = await tags;

    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notițe"),
        backgroundColor: Colors.purple,
        actions: selectedNotes.isNotEmpty
            ? [
          FutureBuilder<List<Tag>>(
            future: tags,
            builder: (BuildContext context,
                AsyncSnapshot<List<Tag>> snapshot,) {
              return PopupMenuButton<Tag>(
                tooltip: "Aplică tag",
                icon: const Icon(Icons.tag),
                onSelected: (tag) async {
                  await Note()
                      .select()
                      .id
                      .inValues(selectedNotes)
                      .update({"tag": tag.id});
                  selectedNotes = [];
                  await updateView();
                },
                itemBuilder: (BuildContext context) {
                  var data = snapshot.data ?? [];

                  return <PopupMenuEntry<Tag>>[
                    ...data
                        .map(
                          (tag) => PopupMenuItem<Tag>(
                        value: tag,
                        child: ListTile(
                          title: Text(tag.tag!),
                          selected: selectedTag?.id == tag.id,
                        ),
                      ),
                    )
                        .toList(),
                  ];
                },
              );
            },),
          IconButton(
            onPressed: () async {
              await Note().select().id.inValues(selectedNotes).delete();

              await updateView();
            },
            icon: const Icon(Icons.delete),
          )
        ]
            : [
          // TODO:
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          FutureBuilder<List<Tag>>(
            future: tags,
            builder: (BuildContext context,
                AsyncSnapshot<List<Tag>> snapshot,) {
              return PopupMenuButton<Tag>(
                tooltip: "See by tag",
                icon: const Icon(Icons.tag),
                onSelected: (tag) async {
                  if (tag.id == null) {
                    selectedTag = null;
                  } else {
                    selectedTag = tag;
                  }
                  await updateView();
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<Tag>>[
                    ...(snapshot.data ?? [])
                        .map(
                          (tag) => PopupMenuItem<Tag>(
                        value: tag,
                        child: ListTile(
                          title: Text(tag.tag!),
                          selected: selectedTag?.id == tag.id,
                        ),
                      ),
                    )
                        .toList(),
                    PopupMenuItem<Tag>(
                      value: Tag(),
                      child: ListTile(
                        title: const Text("All Tags"),
                        selected: selectedTag?.id == null,
                      ),
                    )
                  ];
                },
              );
            },),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await updateView();
        },
        child: FutureBuilder<List<Note>>(
          future: notes,
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.hasData) {
              var data = sortNotes(
                snapshot.data!,
                ascending: ascending,
                by: sortBy,
              );

              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1,
                  );
                },
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  Note note = data[index];
                  bool isSelected = selectedNotes.contains(note.id!);
                  return Column(
                    children: [
                      ListTile(
                        onLongPress: () {
                          setState(() {
                            if (isSelected) {
                              selectedNotes.remove(note.id);
                            } else {
                              selectedNotes.add(note.id!);
                            }
                          });
                        },
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotePage(note: note),
                            ),
                          );
                          await updateView();
                        },
                        title: Text(
                          note.title!,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.body!.substring(
                                0,
                                note.body!.length > 30 ? 30 : note.body!.length,
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (note.tag != null &&
                                    _tags
                                        .where(
                                          (element) => element.id == note.tag,)
                                        .isNotEmpty)
                                  Text(
                                    "#${_tags.where((element) => element.id == note.tag).first.tag}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontStyle: FontStyle.italic,),
                                  )
                                else
                                  const Text(""),
                                Text(
                                  DateFormat("E, MMM d, HH:mm")
                                      .format(note.updatedAt!),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.blue)
                            : null,
                      )
                    ],
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Adaugă notiță",
        backgroundColor: Colors.purple,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotePage(
                note: Note(
                  body: "",
                  title: "",
                  createdAt: DateTime.now(),
                ),
              ),
            ),
          ).then(onGoBack);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: navigation(context),
    );
  }
}
