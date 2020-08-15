//+build mage

package main

import (
	"io/ioutil"
	"log"
	"os"
	"path"

	"github.com/magefile/mage/sh"
	//    "github.com/magefile/mage/sh"
)

// Runs go mod download and then installs the binary.
func Build() error {
	files, err := ioutil.ReadDir("./")
	if err != nil {
		log.Fatal(err)
	}

	for _, f := range files {
		if f.IsDir() {
			if _, err = os.Stat(path.Join(f.Name(), "Flekszible")); err == nil {
				log.Println("Testing " + f.Name())
				err = sh.Run("flekszible", "generate", f.Name())
				if err != nil {
					return err
				}
			}

		}
	}
	return nil
}
