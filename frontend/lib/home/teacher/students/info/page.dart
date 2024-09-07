import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:get/get.dart';

class StudentInfoPage extends StatelessWidget {
  final Aluno aluno;

  StudentInfoPage({super.key, required this.aluno});

  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do aluno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/profile.png',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aluno.nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Situação: Regular',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 16),
                Text(
                  'Email: email@example.com',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 16),
                Text(
                  'Telefone: (99) 99999-9999',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 16),
                Text(
                  'Data de nascimento: 01/01/2000',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.class_rounded),
                SizedBox(width: 16),
                Text(
                  'Turmas: 3',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para criar o acesso do aluno
                    Get.defaultDialog(
                      contentPadding: const EdgeInsets.all(16),
                      title: 'Criar Acesso',
                      content: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(
                            labelText: 'Usuário',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Lógica para criar o acesso do aluno
                            if (formKey.currentState!.validate()) {
                              Get.back();

                              Get.dialog(
                                const Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(24),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CircularProgressIndicator(),
                                        Text('Criando acesso...'),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                              );

                              await Future.delayed(const Duration(seconds: 2));

                              Get.back();

                              Get.defaultDialog(
                                barrierDismissible: false,
                                contentPadding: const EdgeInsets.all(16),
                                onWillPop: () async => false,
                                title: 'Acesso criado',
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Usuário:',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          controller.text,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Senha temporária: ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text('123456'),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.copy),
                                          onPressed: () async {
                                            await Clipboard.setData(
                                              const ClipboardData(
                                                text: '123456',
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('Fechar'),
                                  ),
                                ],
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: const Text(
                            'Criar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                  child: const Text('Criar Acesso'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: true
                      ? null
                      : () {
                          Get.defaultDialog(
                            contentPadding: const EdgeInsets.all(16),
                            title: 'Revogar Acesso',
                            content: const Text(
                              'Deseja realmente revogar o acesso?',
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  // Lógica para revogar o acesso do aluno
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  'Revogar Acesso',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Revogar Acesso',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
