
load('dylan_type_list')
load('beatles_type_list')

hold on
plot(dylan_type_list, 'b')
plot(beatles_type_list, 'r')
legend('Dylan', 'Beatles')
xlabel('Tokens')
ylabel('Types')
