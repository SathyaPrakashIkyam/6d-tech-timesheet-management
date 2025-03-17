import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_management/utils/customAppBar.dart';
import 'package:timesheet_management/utils/customDrawer.dart';

import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';




class CreateWBS extends StatefulWidget {
  const CreateWBS({super.key});

  @override
  State<CreateWBS> createState() => _CreateWBSState();
}

class _CreateWBSState extends State<CreateWBS> {
  final List displayListItems = [
    {
      'id': '2246',
      'name': 'Project 01',
      'priority': 'High',
      'priorityColor': Colors.green,
      'status': 'Ongoing',
      'statusColor': Colors.orange,
      'startDate': '16/12/2024',
      'dueDate': '16/12/2024',
      'members': ['R',]
    },
    {
      'id': '2334',
      'name': 'Project 02',
      'priority': 'Low',
      'priorityColor': Colors.red,
      'status': 'Completed',
      'statusColor': Colors.green,
      'startDate': '18/12/2024',
      'dueDate': '18/12/2024',
      'members': ['G' ]
    },
    {
      'id': '2414',
      'name': 'Project 03',
      'priority': 'Medium',
      'priorityColor': Colors.orange,
      'status': 'Yet to start',
      'statusColor': Colors.red,
      'startDate': '20/12/2024',
      'dueDate': '20/12/2024',
      'members': [ 'A', 'K',"Te"]
    },

  ];
  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      drawer: const AppBarDrawer(drawerWidth: 200,selectedDestination: 2),
      body: Row(
        children: [
          const CustomDrawer(200,2),
          Expanded(
            child: Scaffold(


              body:AdaptiveScrollbar(
                controller: _verticalScrollController,
                underColor: Colors.blueGrey.withOpacity(0.3),
                sliderDefaultColor: Colors.grey.withOpacity(0.7),
                sliderActiveColor: Colors.grey,
                position: ScrollbarPosition.right,
                child: AdaptiveScrollbar(
                  position: ScrollbarPosition.bottom,
                  underColor: Colors.blueGrey.withOpacity(0.3),
                  sliderDefaultColor: Colors.grey.withOpacity(0.7),
                  sliderActiveColor: Colors.grey,
                  controller: _horizontalScrollController,
                  child: SingleChildScrollView(
                    controller: _verticalScrollController,
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10,right: 45,left: 30),
                          child: Card(elevation: 8,
                            child: SizedBox(width: MediaQuery.of(context).size.width >1140 ?MediaQuery.of(context).size.width-290:1140,
                              child:  Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppBar(
                                    foregroundColor: Colors.indigo,
                                    backgroundColor: Colors.white,
                                    surfaceTintColor: Colors.blueAccent,
                                    title: const Text(
                                      "Create WBS",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    automaticallyImplyLeading: true,
                                  ),
                                  const SizedBox(height: 18,),
                                  const SizedBox(width: 1000,child: CreateWBSPage())



                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}

class CreateWBSPage extends StatefulWidget {
  const CreateWBSPage({super.key});

  @override
  State<CreateWBSPage> createState() => _CreateWBSPageState();
}

class _CreateWBSPageState extends State<CreateWBSPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String? selectedProject;
  String? priority;
  String? status ;
  String? billing ;
  String? attachment;

  String? wbsName;
  String? description;
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        attachment = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 700,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Name Dropdown
                    buildLabel("Project Name",isMan: true),
                    DropdownButtonFormField<String>(
                      decoration: inputDecoration("Select Project"),
                      value: selectedProject,
                      onChanged: (value) => setState(() => selectedProject = value),
                      validator: (value) => value == null ? 'Please select a project' : null,
                      items: ['Project A', 'Project B', 'Project C']
                          .map((proj) => DropdownMenuItem(
                        value: proj,
                        child: Text(proj, style: const TextStyle(fontSize: 16)),
                      ))
                          .toList(),
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                      isExpanded: true,
                    ),
                    const SizedBox(height: 26),

                    // WBS Name Input
                    buildLabel("WBS Name",isMan: true),
                    TextFormField(
                      decoration: inputDecoration("Enter WBS Name"),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'WBS Name is required';
                        }
                        return null;
                      },
                      onSaved: (value) => wbsName = value,
                    ),
                    const SizedBox(height: 16),

                    // Description Input (Optional)
                    buildLabel("Description"),
                    TextFormField(
                      decoration: inputDecoration("(Optional)"),
                      maxLines: 5,
                      onSaved: (value) => description = value,
                    ),
                    const SizedBox(height: 24),

                    buildLabel("Assignee",isMan: true),
                    TextFormField(decoration: inputDecoration("Assignee"),
                      validator: (value)  {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please select';
                      }
                      return null;
                    },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel("Start Date"),
                        TextFormField(
                          readOnly: true,
                          controller: _startDateController,
                          decoration: dateInputDecoration("Start Date",_startDateController),
                          onTap: ()=>_selectDate(context, _startDateController),
                          validator: (value)  {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please select Date';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel("End Date",isMan: true),
                        TextFormField(
                          readOnly: true,
                          controller: _endDateController,
                          decoration: dateInputDecoration("End Date",_endDateController),
                          onTap: ()=>_selectDate(context, _endDateController),
                          validator: (value)  {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please select Date';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel("Priority",isMan: true),
                        DropdownButtonFormField<String>(
                          decoration: inputDecoration("Priority"),
                          value: priority,
                          onChanged: (value) => setState(() => priority = value),
                          validator: (value) => value == null ? 'Please select a Priority' : null,
                          items: ['High', 'Medium', 'Low']
                              .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                              .toList(),
                          icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.blue),
                          isExpanded: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel("Status",isMan: true),
                        DropdownButtonFormField<String>(
                          decoration:inputDecoration("Status"),
                          value: status,
                          validator: (value) => value == null ? 'Please select a Status' : null,
                          onChanged: (value) => setState(() => status = value),
                          items: ['InProgress', 'Completed', 'OnHold']
                              .map((state) => DropdownMenuItem(value: state, child: Text(state)))
                              .toList(),
                          icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.blue),
                          isExpanded: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel("Status",isMan: true),
                        DropdownButtonFormField<String>(
                          decoration:inputDecoration("Billing"),
                          validator: (value) => value == null ? 'Please select' : null,
                          value: billing,
                          onChanged: (value) => setState(() {
                            billing = value;

                          }),
                          items: ['Billable', 'Non-Billable']
                              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                              .toList(),
                          icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.blue),
                          isExpanded: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                   OutlinedButton.icon(
                     icon: const Icon(Icons.attach_file),
                     label: Text(attachment ?? 'Upload'),
                     onPressed: _pickFile,
                   ),
                  const Spacer(),
                  SizedBox(height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _submitForm();

                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text('Create WBS', style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),

                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
  // Label Widget for consistency
  Widget buildLabel(String text, {bool ? isMan}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5,left: 3),
            child: Text(
             isMan==true ? "*":"",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Custom Input Decoration for a consistent look
  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[100],
      labelText: labelText,
      labelStyle:   const TextStyle(fontSize: 13),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  InputDecoration dateInputDecoration(String labelText, TextEditingController startDateController) {
    return InputDecoration(
      labelText: labelText,labelStyle:   const TextStyle(fontSize: 13),
      filled: true,
      fillColor: Colors.grey[100],
      suffixIcon: IconButton(
        icon: const Icon(Icons.calendar_today,color: Colors.blue),
        onPressed: () => _selectDate(context, startDateController),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  // Form Submission Logic
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form fields

      // Simulate form submission (Replace with actual logic)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Form Submitted: $selectedProject, $wbsName, $description"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}


