#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>

void patch ();

int main()
{
    sf::RenderWindow window(sf::VideoMode(1500, 1100), "Welcum to the SuPer-DuPeRR CRacK prOGrum");

    sf::Texture Frame;
    sf::Sprite sprite;
    sprite.setPosition (100, 100);

    sf::Music music;
    if (!music.openFromFile("prettymusic.ogg"))
        return EXIT_FAILURE;

    char current_frame[54] = {0};

    sprintf(current_frame, "img/HACKERMAN.jpg\0");

    if (!Frame.loadFromFile(current_frame)) 
    {
        return EXIT_FAILURE;
    }

    sprite.setTexture(Frame);
    window.draw(sprite);

    window.display();

    sleep (10);

    music.play ();

    patch ();

    while (window.isOpen ())
    {
        sf::Event event;
        while (window.pollEvent (event))
            if (event.type == sf::Event::Closed)
                window.close ();

        window.clear ();

        for (int i = 100; i < 301; i++) 
        {
            sprintf (current_frame, "img/Spongebob performs _We Are the Champions__%d.jpg", i);

            if (!Frame.loadFromFile(current_frame)) 
            {
                return EXIT_FAILURE;
            }

            sprite.setTexture (Frame);
            window.draw (sprite);
            window.display ();

            usleep (100000);
        }
        window.close ();
    }

    return 0;


    //g++ -I"D:\libs\SFML-2.5.1\include" -c patcher.cpp -o patcher.o
    //g++ -LD:\libs\SFML-2.5.1\lib .\patcher.o -o patcher.exe -lmingw32 -lsfml-graphics -lsfml-window -lsfml-system -lsfml-main -lsfml-audio -mwindows
}

void patch () 
{
    FILE* binary = fopen("sucker.com", "r+");

    if (!binary)
    {
        fprintf(stderr, "NO FILE!\n");
        abort();
    }

    unsigned char hack[] = {9*16, 9*16};
    fseek(binary, 0x1b, SEEK_SET);
    fwrite(hack, sizeof(char), 2, binary);
    fclose(binary); 
}